Message-Id: <4.2.0.58.19990701115628.0377f1f0@mail.lauterbach.com>
Date: Thu, 01 Jul 1999 11:59:51 +0200
To: Albrecht =?iso-8859-1?Q?Dre=DF?= <ad@MPIfR-Bonn.MPG.de>
From: Franz Sirl <Franz.Sirl@munich.netsurf.de>
Subject: Re: LinuxPPC & gcc optimizer flags
Cc: LinuxPPC Users <linuxppc-user@lists.linuxppc.org>,
        LinuxPPC-Dev Liste <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <377B315B.BBC64BA6@mpifr-bonn.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 11:14 01.07.99 , Albrecht Dreß wrote:
>Hi all,
>
>         there was recently some discussion about the usage of different 
> gcc optimizer
>flags with LinuxPPC.  I ran the HINT benchmark on may PowerBook G3/300, 192 MB
>Ram, LinuxPPC Release 5 with all combinations of the -O[0123] and
>-mcpu={|603|604|750} flags.  Plots of the results are attached as ps files.
>Interestingly, the best results are achieved with "-O2 -mcpu=603" or "-O3
>-mcpu=603" and NOT with -mcpu=750....

Which compiler did you use? Up to egcs-1.1.2, -mcpu=750 is a no-op :-). Did 
you also try different mixings of -march= and -mtune=?

If you are on R5, I can provide you gcc-2.95pre RPM's which support -mcpu=750.

Franz.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
