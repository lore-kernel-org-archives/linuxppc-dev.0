Message-Id: <5.1.0.14.2.20030708195315.038110e8@mail.ebshome.net>
Date: Tue, 08 Jul 2003 19:56:28 -0700
To: Dean Matsen <deanmatsen@earthlink.net>
From: Eugene Surovegin <ebs@ebshome.net>
Subject: Re: Ethernet PHY chip discovery not working on 855T with
  971/972 chips
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <3F0B7DF7.5050107@earthlink.net>
References: <3F0B7B28.7040902@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 07:29 PM 7/8/2003, Dean Matsen wrote:

>Dean Matsen wrote:
>
>>
>>In our devices, reading the first word with the wrong address yields the
>>value 0, not 0xFFFF.
>
>I suspect that this may have been part of the problem in
>
>http://lists.linuxppc.org/linuxppc-embedded/200107/msg00141.html
>
>but that's a guess.

It usually means that your hw lacks pull-up on MII MDIO line.

Eugene


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
