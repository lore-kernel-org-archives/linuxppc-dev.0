Message-ID: <3E2EDD3E.1000502@embeddededge.com>
Date: Wed, 22 Jan 2003 13:04:46 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: joakim.tjernlund@lumentis.se
Cc: Shen Rong <rshen@udtech.com.cn>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: wrong definition in cpm_8260.h?
References: <IGEFJKJNHJDCBKALBJLLKEIJFJAA.joakim.tjernlund@lumentis.se>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Joakim Tjernlund wrote:

> The same error is in commproc.h for 8xx as well.

It's not an error in either driver since first/last will always be
set in every buffer.  There isn't any reason for the driver to test
or take any action based upon these indicators.

These are not data transfer error or status indicators in the sense
they indicate some condition on the network itself.  These are buffer
management indicators that should be managed as such if they are used.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
