Message-Id: <v04003a00b628feabbda6@[24.70.162.12]>
In-Reply-To: <p04330100b627ff09296b@[192.168.0.1]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 3 Nov 2000 17:52:22 -0600
To: Stefan Jeglinski <jeglin@4pi.com>, linuxppc-dev@lists.linuxppc.org
From: Tony Mantler <nicoya@apia.dhs.org>
Subject: Re: whacked out 2.2.18pre17?
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 11:53 PM -0600 11/2/2000, Stefan Jeglinski wrote:
>The second night, it booted, but the no video checkbox was somehow
>inverted in operation. IOW, with no video turned on (I have a twin
>turbo card, OFfb is my only choice in running X), I never get the
>OFfb driver, it always insists on loading the imsttfb driver, so X is
>impossible.

The IMS TT in my 9600/200mp has never given me any troubles at all with
imsttfb and X. The only quirk is that the dotclock values are off, but read
and write consistently and reliably.

This is using a Linus-2.2.17 with PCI and IDE patches, and the latest
debian-unstable packaging of X.


Cheers - Tony 'Nicoya' Mantler :)


--
Tony "Nicoya" Mantler - Renaissance Nerd Extraordinaire - nicoya@apia.dhs.org
Winnipeg, Manitoba, Canada           --           http://nicoya.feline.pp.se/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
