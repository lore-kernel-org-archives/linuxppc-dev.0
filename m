Message-ID: <392A5243.D91A0E95@pop.agri.ch>
Date: Tue, 23 May 2000 11:41:25 +0200
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: Ethan Benson <erbenson@alaska.net>
CC: Linux -Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: OF & adaptec2940UW on 7200
References: <39295A52.9E767503@pop.agri.ch> <20000523011019.R7243@plato.local.lan>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ethan Benson wrote:
> have you tried /bandit@F2000000/ADPT,2940UW@E/@2:0 <-- notice the :0

I think I tried it, but have to retry. What I tried and what didn't work
was the following:
0 > setenv boot-device /bandit/ADPT,2940UW/@2:0  ok
0 > boot  can't OPEN: /bandit/ADPT,2940UW/@2:0

Only to show, bandit and ADPT,2940UW are known:
0 > dev /bandit  ok
0 > dev ADPT,2940UW  ok
0 > pwd /bandit@F2000000/ADPT,2940UW@E ok

Under ADPT I typed 'words' to see what's around, I didn't find a 'open'
as I find under 53c94. Doesn't mean that this is the point but it made
me curious.

>
> you need to specify that partition number to quik, quik uses partition
> 0 to indicate that it should use the parititon marked bootable in the
> partition table.  i think you could specify the root partition here as
> well but im not sure of that.

[snipp]

> let me know if your kernel (if 2.2.15) boots ;-)

Haeh, with bootx it still does, but the other way round I have to learn
a lot. Or buy a G4 ;-)

The last step would be attach an external narrow disk to the 53c94 and
try to boot from there. But this is a step back since the other disks
are UW/U2W.

Thanks,
Andreas

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
