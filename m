Message-ID: <3F0BAE62.50408@earthlink.net>
Date: Tue, 08 Jul 2003 22:55:46 -0700
From: Dean Matsen <deanm@earthlink.net>
MIME-Version: 1.0
To: Dmytro Bablinyuk <dmytro.bablinyuk@tait.co.nz>
Cc: linuxppc mail list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Problem with starting up 2.4.21 kernel
References: <3F0B9F69.1030801@tait.co.nz>
In-Reply-To: <3F0B9F69.1030801@tait.co.nz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dmytro Bablinyuk wrote:

>
> sramsize = 0x00000000
> immr_base = 0x02200000
> bootflags = 0x00000001
>
Just a sanity check, but that immr_base sounds pretty low to me... we
always use 0xFxxx0000.
This is not necessarily wrong, but make sure this is what you want. In
fact, I think I read
in a comment somewhere that in some cases it MUST match the value of
your boot loader.

Dean


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
