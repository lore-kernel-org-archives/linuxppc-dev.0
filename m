Message-Id: <4.2.0.56.19990621112016.009bd720@mail.lauterbach.com>
Date: Mon, 21 Jun 1999 11:31:09 +0200
To: Eric Ding <ericding@applix.com>
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: ld bug with -Bsymbolic --noinhibit-exec
  (2.9.1.0.990418-1c)
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <199906181954.PAA01284@tuxedo.applix.com>
References: <Message from Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
 <99061723274300.01016@ns1102.munich.netsurf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 21:54 18.06.99 , Eric Ding wrote:
>Hi Franz,
>
>thanks for your help so far.  After upgrading to 1b, linking works, but
>actually running against those shared libraries doesn't seem to
>necessarily work.  But it's hard for me to tell where the bug is.

If you still have problems after upgrading to 2.9.4.0.6 below, I'm willing 
to look further into it, but I assume it will be difficult, as you don't 
know the exact cause yourself. Can we rule out bugs in your source here? 
Did the executables created with 2.9.4.0.5 on x86 work fine? I'll also post 
my patch for the noinhibit-exec problem on the binutils-list for review 
later today.

>The fact that LD_RUN_PATH needed to be set is still a red flag in my
>mind... is that "correct" behavior?  I know that Applixware linked and
>ran OK with binutils from R4; would backtracking be an adequate
>solution?

Ok, the LD_RUN_PATH should be fixed now with:

ftp://dev.linuxppc.org/users/fsirl/R5/RPMS/ppc/binutils-2.9.4.0.6-1a.ppc.rpm

Franz.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
