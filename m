Message-Id: <199904042337.XAA00413@Taygeta.gom.dorm.org>
Date: Sun, 4 Apr 1999 23:37:53 +0000 (Local time zone must be set--see zic manual page)
From: Guillaume Laures <GoM@Taygeta.gom.dorm.org.cybercable.fr>
Subject: Re: [ANNC] New release of PlanB
To: mlan@cpu.lu
cc: linux-pmac@samba.anu.edu.au, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <199904042044.WAA03236@piglet.cpu.lu>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  5 Avr, Michel Lanners wrote:
> Hi all,
> 
> I just uploaded a new version of the PlanB driver to my site:
Patches begin to be hard to follow :-) (but it's better like that)

>From the previous release, I have to say that switching to console when
xawtv (2.40 --fb) is runnig is really uglier than before. Didn't try
0.06 yet to see if it has changed.

Anyway I must report that I had several crashes recently (actually 3 in
a week, which is definitely much for linux) since I upgraded to 2.2.5,
with the planb as well. I have only controlfb in the kernel on a
8600/250 and use the XFB, and i get hard locks when switching quickly
beetwen X and console.
Don't know to what it could be related to. Can other people comment on
this ?

-- 
---
Guillaume Laurès laures@esiea.fr


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
