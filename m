Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <19213.61189.559138.936155@drongo.ozlabs.ibm.com>
Date: Thu, 26 Nov 2009 13:59:17 +1100
From: Paul Mackerras <paulus@samba.org>
To: Nathan Fontenot <nfont@austin.ibm.com>
Subject: Re: [PATCH v2 1/3] Kernel DLPAR Infrastructure
In-Reply-To: <4B0CD879.9020400@austin.ibm.com>
References: <4B0CD70F.6090600@austin.ibm.com> <4B0CD879.9020400@austin.ibm.com>
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

> The Dynamic Logical Partitioning capabilities of the powerpc pseries platform
> allows for the addition and removal of resources (i.e. CPU's, memory, and PCI
> devices) from a partition. The removal of a resource involves
> removing the resource's node from the device tree and then returning the
> resource to firmware via the rtas set-indicator call.  To add a resource, it
> is first obtained from firmware via the rtas set-indicator call and then a
> new device tree node is created using the ibm,configure-coinnector rtas call
> and added to the device tree. 
> 
> This patch provides the kernel DLPAR infrastructure in a new filed named
> dlpar.c.  The functionality provided is for acquiring and releasing a resource
> from firmware and the parsing of information returned from the
> ibm,configure-connector rtas call.  Additionally this exports the pSeries
> reconfiguration notifier chain so that it can be invoked when device tree 
> updates are made.
> 
> Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com> 

Acked-by: Paul Mackerras <paulus@samba.org>
