Subject: Re: Riscwatch debugging
From: Hollis Blanchard <hollis@austin.ibm.com>
To: Ralph Blach <rcblach@us.ibm.com>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <OF602712C4.C8A0E6C9-ON87256C59.00432EAF@boulder.ibm.com>
References: <OF602712C4.C8A0E6C9-ON87256C59.00432EAF@boulder.ibm.com>
Date: 22 Oct 2002 12:32:02 -0500
Message-Id: <1035307922.29361.8.camel@granite.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 2002-10-21 at 07:15, Ralph Blach wrote:
>
> Try compiling with -dwarf2.  We have no problem with symbolic debug with
> riscwatch here.
>
> You will also need to set you srchpath to inclulde the .o file that contain
> the debug info

Could you be more specific? I've just built a kernel with gcc 3.2 -g
(defaults to dwarf2). What must I add to my srchpath so I can debug the
whole kernel (not a particular object file)?

Currently I have linux/ (for the vmlinux debug info?) and
linux/arch/ppc/boot/images (to load the zImage). I've loaded with 'load
image zImage.initrd.treeboot', but all the Source windows remain blank.

-Hollis

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
