Message-ID: <3BEBB59E.3060202@humboldt.co.uk>
Date: Fri, 09 Nov 2001 10:53:18 +0000
From: Adrian Cox <adrian@humboldt.co.uk>
MIME-Version: 1.0
To: Bastien Nocera <hadess@hadess.net>
Cc: "Jeramy B. Smith" <jeramy@penguinppc.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] aty128fb.c
References: <Pine.LNX.4.33.0111090300500.737-100000@penguinppc.org> <1005301549.3bebaf2d1e55f@imp.free.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Bastien Nocera wrote:

> Quoting "Jeramy B. Smith" <jeramy@penguinppc.org>:
>>This removes a block of cruft leftover from the iMac days and sets the
>>default resolution for aty128fb on PPCs to 640x480-60 (ensuring even
>>the
>>cruddiest of monitors will work).
> The iBook2 doesn't support 640x480 afaik


That should be dealt with by these lines:

	    /* PowerBook Firewire (Pismo), iBook Dual USB */
	    if (machine_is_compatible("PowerBook3,1") ||
	    	machine_is_compatible("PowerBook4,1"))
		default_vmode = VMODE_1024_768_60;


--
Adrian Cox   http://www.humboldt.co.uk/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
