Mime-Version: 1.0
Message-Id: <p04330100b629125ff911@[192.168.0.1]>
In-Reply-To: <v04003a00b628feabbda6@[24.70.162.12]>
References: <v04003a00b628feabbda6@[24.70.162.12]>
Date: Fri, 3 Nov 2000 20:15:34 -0500
To: linuxppc-dev@lists.linuxppc.org
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: Re: whacked out 2.2.18pre17?
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>  >The second night, it booted, but the no video checkbox was somehow
>>inverted in operation. IOW, with no video turned on (I have a twin
>>turbo card, OFfb is my only choice in running X), I never get the
>>OFfb driver, it always insists on loading the imsttfb driver, so X is
>>impossible.
>
>The IMS TT in my 9600/200mp has never given me any troubles at all with
>imsttfb and X. The only quirk is that the dotclock values are off, but read
>and write consistently and reliably.
>
>This is using a Linus-2.2.17 with PCI and IDE patches, and the latest
>debian-unstable packaging of X.


Well, this is unlike most users of Twin Turbo cards, if the past list
traffic is any measure. Interestingly, I have seen comments before
that the issue is not the imsttfb driver, but X itself. This would
not be inconsistent with your setup, given the debian X. I would love
to get the twin turbo working, I have been waiting for X4 to get far
enough along, but it appears to still be lacking in even
straightforward atyfb support (debugged that is), as per the last I
read. Older ATI Rage Pro card(s) are what else I have, but it won't
do me any good to get one card working if another that I have breaks.


Stefan Jeglinski

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
