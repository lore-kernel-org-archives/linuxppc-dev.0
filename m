Message-ID: <E69FF45ADA3BD511A25900047623CC4F12AA7D@JUPITER>
From: Neil Wilson <NWILSON@Airspan.com>
To: "'Dan Malek'" <dan@mvista.com>, Neil Wilson <NWILSON@Airspan.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Sandpoint 3 + MPC7450 + HHL2
Date: Fri, 29 Jun 2001 12:28:31 +0100
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>I'm sitting on a bunch of changes for both Sandpoint X3 and 7450.  With
>the new cputable stuff in 2.4_devel, I'll stuff the 7450 changes in
>there.

sounds good to me

>> ...after adding a enable for the TimeBase

>So, you have an old version of DINK.  Get it updated as you are probably
>missing more than that.

I am using dink32 v12.2 of 16Feb2001.  My Abatron sets the TBEN bit, I run &
halt dink32 after getting the dink prompt and TBEN is still set but when I
run the downloaded zImage and halt when it "appears" to hang TBEN has been
cleared.

Neil

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
