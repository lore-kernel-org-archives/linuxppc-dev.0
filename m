Message-ID: <3BE8D69D.5020600@mvista.com>
Date: Wed, 07 Nov 2001 01:37:17 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: hollis@austin.ibm.com
Cc: linuxppc-dev@lists.linuxppc.org, davidm@amberdata.demon.co.uk,
	Sven.Dickert@planb.de
Subject: Re: RFC: i8259.c cleanup
References: <20011106171559.D9471@austin.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


hollis@austin.ibm.com wrote:


> The following patch (to linuxppc_2_4_devel) does exactly that - it reads from
> 0xbffffff0 instead of the 8259 directly.

Ummmmm.....this probably works OK on PReP, but I don't think it is going
to have the desired effect on other systems using an 8259 :-).  You need
to find a way to to make the code you changed unique to PReP.

Thanks.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
