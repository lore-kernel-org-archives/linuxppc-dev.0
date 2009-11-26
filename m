Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <19213.61231.695292.875347@drongo.ozlabs.ibm.com>
Date: Thu, 26 Nov 2009 13:59:59 +1100
From: Paul Mackerras <paulus@samba.org>
To: Nathan Fontenot <nfont@austin.ibm.com>
Subject: Re: [PATCH v2 3/3]CPU DLPAR handling
In-Reply-To: <4B0CD91C.1090704@austin.ibm.com>
References: <4B0CD70F.6090600@austin.ibm.com> <4B0CD91C.1090704@austin.ibm.com>
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

> This patch adds the specific routines to probe and release (add and remove)
> cpu resource for the powerpc pseries platform and registers these handlers
> with the ppc_md callout structure.
> 
> Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>

Acked-by: Paul Mackerras <paulus@samba.org>
