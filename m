Message-Id: <199904052126.VAA00422@Taygeta.gom.dorm.org>
Date: Mon, 5 Apr 1999 21:26:16 +0000 (Local time zone must be set--see zic manual page)
From: Guillaume Laures <GoM@Taygeta.gom.dorm.org.cybercable.fr>
Subject: Re: [ANNC] New release of PlanB
To: GoM@Taygeta.gom.dorm.org.cybercable.fr
cc: mlan@cpu.lu, linux-pmac@samba.anu.edu.au, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <199904042337.XAA00413@Taygeta.gom.dorm.org>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  4 Avr, Guillaume Laures wrote:
>
> 
> Anyway I must report that I had several crashes recently (actually 3 in
> a week, which is definitely much for linux) since I upgraded to 2.2.5,
> with the planb as well. I have only controlfb in the kernel on a
> 8600/250 and use the XFB, and i get hard locks when switching quickly
> beetwen X and console.
> Don't know to what it could be related to. Can other people comment on
> this ?

I might add that I run Login.app as X starter, and it is not really
reliable (sometimes X is frozen, Login.app takes 90% of CPU and all I
can do is telnet from another machine, su and kill it).
This may more likely be my problem.


BTW, for people looking into raid, I can provide a patch for 2.2.5. I
don't send it right now cause it includes planB as well...

-- 
---
Guillaume Laurès laures@esiea.fr


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
