Message-ID: <39295A52.9E767503@pop.agri.ch>
Date: Mon, 22 May 2000 18:03:43 +0200
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: Linux -Dev <linuxppc-dev@lists.linuxppc.org>
Subject: OF & adaptec2940UW on 7200
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I try to get my pm7200 to run with quik. I have an Adaptec 2940UW with
the latest (dec 99) firmware. Two disk attached to this card. No other
discs in this machine.
Now I have some troubles accessing the disks from OF. It can't find it.
here the dev / ls:
FF831AC8: /bandit@F2000000
FF832CB8:   /gc@10
FF8330F0:     /53c94@10000
FF834978:       /sd@0,0
FF8355A8:       /st@0,0
FF836220:     /mace@11000
FF837098:     /escc@13000
FF8371F0:       /ch-a@13020
FF8378A0:       /ch-b@13000
FF837F50:     /awacs@14000
FF838038:     /swim3@15000
FF839140:     /via-cuda@16000
FF839CD0:       /adb@0,0
FF839DC0:         /keyboard@0,0
FF83A510:         /mouse@1,0
FF83A5C0:       /pram@0,0
FF83A670:       /rtc@0,0
FF83AB38:       /power-mgt@0,0
FF83ACE0:     /nvram@1D000
FF83BD90:   /pci106b,1@B
FF83BF68:   /pci10b7,5900@D
FF83C1F8:   /ADPT,2940UW@E		<--- the card.
FF864AB8:   /pci10b7,9055@F
FF83AF90: /platinum@F8000000

Now I think I miss the /sd and /st entries behind the /ADPT entry. I
followed the parts of the yaboot-faq, to find out about disk naming
under OF.
I set the boot-device like this: /bandit@F2000000/ADPT,2940UW@E/@2 for
the second disk.
On boot cmd it only says can't open the above.

Are there some people having a similar card/experience?
Also, creating alias'es under this OF doesn't seem to work. (OF-1.0.5)
0 > nvalias sd /bandit@F2000000/ADPT,2940UW@E  ok
0 > nvstore NVRAMRC not valid

Any hints would be great,

Thanks

Andreas

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
