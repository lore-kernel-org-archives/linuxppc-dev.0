Message-Id: <20010119141033.Postino-012193@smtp01.highway.ne.jp>
Date: Fri, 19 Jan 2001 14:10:33 +0900
To: eraineri@axiom-tx.com
CC: linuxppc-dev@lists.linuxppc.org
From: Kaoru Fukui <k_fukui@highway.ne.jp>
Subject: Re: kernel 2.4 SMP on quad PPC
In-Reply-To: <3A6748FB.42C51F82@axiom-tx.com>
References: <3A6748FB.42C51F82@axiom-tx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


From: eraineri@axiom-tx.com
To: linuxppc-dev@lists.linuxppc.org
Subject: kernel 2.4 SMP on quad PPC
Date: Thu, 18 Jan 2001 13:50:19 -0600

>
> Hello,
> I have searched the arhives and didn't seem to find what I'm looking
> for.  I currently am in the process of porting linux to a custom PPC
> Quad board.  I downloaded a 2.5 kernel  from FSMlabs in December and
> have had success getting 2 processors to come up.  However, I could not
> get 3 or 4.  I am considering going to the 2.4 latest kernel on the
> FSMlabs bitkeeper site.  I'm wondering if the version of the 2.5 kernel
> I downloaded works with more then duals and also if I should instead
> download the 2.4 kernel and us it?  I know that eventually I am going to
> have to go to 2.4 but I would like to show some success before
> abandoning the 2.5 version I've worked so hard to get.  If I in the
> incorrect mailing list I apologize.  I'm fairly new to the Linux kernel
> development world!
>
> Thanks for all the help
> Eddy
>
Yesterday it was fixed just code for multicpu over 2 in smp.c and irq.c.
Try again linuxppc_2_3.

but I don't have multicpu over 2,so i cannot check it.

Kaoru


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
