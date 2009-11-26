Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <19213.61204.591278.856459@drongo.ozlabs.ibm.com>
Date: Thu, 26 Nov 2009 13:59:32 +1100
From: Paul Mackerras <paulus@samba.org>
To: Nathan Fontenot <nfont@austin.ibm.com>
Subject: Re: [PATCH v2 2/3] sysfs cpu probe/release files
In-Reply-To: <4B0CD8D5.8050803@austin.ibm.com>
References: <4B0CD70F.6090600@austin.ibm.com> <4B0CD8D5.8050803@austin.ibm.com>
Cc: linuxppc-dev@ozlabs.org, gregkh@suse.de, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nathan Fontenot writes:

> In order to support kernel DLPAR of CPU resources we need to provide an
> interface to add (probe) and remove (release) the resource from the system.
> This patch Creates new generic probe and release sysfs files to facilitate
> cpu probe/release.  The probe/release interface provides for allowing each
> arch to supply their own routines for implementing the backend of adding
> and removing cpus to/from the system.
> 
> This also creates the powerpc specific stubs to handle the arch callouts 
> from writes to the sysfs files.
> 
> The creation and use of these files is regulated by the 
> CONFIG_ARCH_CPU_PROBE_RELEASE option so that only architectures that need the
> capability will have the files created.
> 
> Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>

Acked-by: Paul Mackerras <paulus@samba.org>
