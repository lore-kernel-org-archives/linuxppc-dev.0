Message-ID: <38FC8569.EC19CFF6@embeddededge.com>
Date: Tue, 18 Apr 2000 11:55:21 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Graham Stoney <greyham@research.canon.com.au>
CC: Dan Malek <dan@netx4.com>,
        LinuxPPC Embedded Mailing List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Bizarre initrd problem on CLLF860T
References: <20000418075704.C3E833C970@elph.research.canon.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Graham Stoney wrote:

> ..... My initrd problem lies in
> the CPU6 workaround in set_dec in arch/ppc/kernel/head.S, which does, err,
> interesting things to the command line!:

Sorry about that.  It was a test hack I forgot about.  I just needed
something aligned and mapped to read/write that was _supposed_ to not
affect anything.  It popped to mind and I never went back to do something
proper......I don't know why it ever worked for me.

Just create some 32-bit aligned variable and use that.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
