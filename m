From: John_McRoberts@Mitel.COM
Subject: Re: Strange Ethernet
To: "David Marqvar (DAM)" <DAM@tt.dk>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>,
	owner-linuxppc-embedded@lists.linuxppc.org
Message-ID: <OF661BA08E.13547817-ON80256B80.003BCE8D@software.mitel.com>
Date: Mon, 18 Mar 2002 10:55:09 +0000
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've seen this and it's down to not initialising the PHY correctly.
You may have to modify the PHY according to your particular device
especially if they are initialising for a particular PHY not the same as
the one you are using. You are in fact not receiving packets back.

Regards,
John



                    "David Marqvar (DAM)"
                    <DAM@tt.dk>                            To:     "'linuxppc-embedded@lists.linuxppc.org'"
                    Sent by:                                <linuxppc-embedded@lists.linuxppc.org>
                    owner-linuxppc-embedded@lists.li       cc:
                    nuxppc.org                             Subject:     Strange Ethernet


                    03/18/02 10:05 AM







We have a very strange problem with ethernet.
We have a "standard" MPC8xxFADS with a MPC823 daugther-board.

The strange thing is that the ethernet does work when we connect the
ethernet port (on target) directly to another computer (with a 3com
netcard)
using a crossed cable. And it does work when we connect it directly to some
big HP switch.
But it does NOT work if we connect the target to a little 5-ports hub
("Edimax", dual speed). There is transmission acording to the LEDs, but we
don't get any response. The ethernet is just not working.

What do you think of that?
Is it the HUB that is not working correctly? It was probably very cheep....
:)

Regards, David


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
