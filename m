Mime-Version: 1.0
Message-Id: <v04205407b394c3a178eb@[209.239.164.131]>
In-Reply-To: 
 <Pine.LNX.3.96L.990622003119.5237E-100000@unix47.andrew.cmu.edu>
References: 
 <Pine.LNX.3.96L.990622003119.5237E-100000@unix47.andrew.cmu.edu>
Date: Mon, 21 Jun 1999 21:39:06 -0700
To: Hollis R Blanchard <hollis+@andrew.cmu.edu>
From: Peter Chang <weasel@cs.stanford.edu>
Subject: Re: dl-load.c (ld.so) bug??
Cc: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > Uhhh... both of these are legal.
>
>Yes, exactly. There is no reason they should do anything bad. Now compile them
>with 'gcc -o bug main.c -lefence -g -static'. They both segfault.

Ooops. I thought that you meant that the were illegal and were not 
getting caught. Sorry.

\p

---
sed quis custodiet ipsos custodes
		--Juvenal *Satire* VI, 165

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
