Date: Fri, 23 Jun 2000 16:35:20 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: "Halfmann, Klaus" <khalfmann@libra.de>
cc: "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Status of hfs support as of 2.4.0-test1-ac21
In-Reply-To: <F14441D40E5AD3118886005004607AD10BDD30@mail.libra.de>
Message-ID: <Pine.LNX.4.10.10006231632470.30966-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>   - hdparm did not always work correctly
>     (I use pmud and it calls hdparm depending on the battery load)
>     Sometimes I got stuck with the message "hda interrupt lost"
>     or similar.

What sort of machine is that on? The lost interrupt should only happen
(copiously) on Pismo when the pwrctl script forces a disk shutdown on
battery low. Having HD requests time out often enough to force a disk
reset is the only way to power up the disk again there.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
