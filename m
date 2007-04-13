Return-Path: <benh@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] [ANNOUNCE] petitboot v0.0.1
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hiroaki Fuse <Hiroaki_Fuse@hq.scei.sony.co.jp>
In-Reply-To: <OFA72EABF2.7008AEF7-ON492572BC.00220AA6-492572BC.00226043@hq.scei.sony.co.jp>
References: <OFA72EABF2.7008AEF7-ON492572BC.00220AA6-492572BC.00226043@hq.scei.sony.co.jp>
Content-Type: text/plain
Date: Fri, 13 Apr 2007 18:54:38 +1000
Message-Id: <1176454479.5764.72.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org,
	cbe-oss-dev-bounces+hiroaki_fuse=hq.scei.sony.co.jp@ozlabs.org,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-04-13 at 15:20 +0900, Hiroaki Fuse wrote:
> 
> Jeremy-san, 
> 
> I tried to use petitboot v0.0.1 and found a problem. 
> 
> I use a following kboot.conf. 
> 
> --- 
> default=linux 
> timeout=10 
> root=LABEL=/ 
> linux='/boot/vmlinux-2.6.16 initrd=/boot/initrd.img-2.6.16 ' 
> linux21='/boot/vmlinux-2.6.21 initrd=/boot/initrd.img-2.6.21 ' 
> --- 
> 
> I saw three entries(root, linux and linux21) and I can not boot any
> kernel. 
> 
> So I changed my kboot.conf as follows. 
> 
> --- 
> default=linux 
> timeout=10 
> linux='/boot/vmlinux-2.6.16 root=LABEL=/
> initrd=/boot/initrd.img-2.6.16 ' 
> linux21='/boot/vmlinux-2.6.21 root=LABEL=/
> initrd=/boot/initrd.img-2.6.21 ' 
> --- 
> 
> And I can boot both kernel. 

Ok, looks like the kboot parser isn't quite dealing with the root=
stance outside of a kernel spec. We'll fix asap

Ben.
