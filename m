Message-Id: <5.2.0.9.2.20021202115327.01d2e420@mail.lauterbach.com>
Date: Mon, 02 Dec 2002 12:17:42 +0100
To: Samuel Rydh <samuel@ibrium.se>
From: Franz Sirl <Franz.Sirl-ppc@lauterbach.com>
Subject: Re: asm inline
Cc: Gabriel Paubert <paubert@iram.es>,
	linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20021129174942.GA833@ibrium.se>
References: <Pine.LNX.4.33.0211291712010.9530-100000@gra-lx1.iram.es>
 <20021129160826.GA27950@ibrium.se>
 <Pine.LNX.4.33.0211291712010.9530-100000@gra-lx1.iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 18:49 29.11.2002, Samuel Rydh wrote:
> > I see that your example involves local variables, does
> > it also happen in the non-automatic case ?
>
>It happens in the non-automatic case too. I'll try the
>latest gcc version later.

Can you please post a compilable code fragment that still shows the bug for
you? Or add -save-temps to the CFLAGS and send me the resulting
preprocessed .i file. I seem to remember a platform independent bug in 3.1
with memory constraints, but it maybe something totally different...

Ah, and don't forget to tell me all the CFLAGS necessary to trigger the bug.

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
