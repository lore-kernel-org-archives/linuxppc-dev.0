Message-ID: <3C18445A.80505@embeddededge.com>
Date: Thu, 13 Dec 2001 01:02:02 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Andrew Dixon <andrew.dixon@seranoa.com>
Cc: ppclist <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: root=/dev/nfs on sbc8260
References: <3C17E07F.7144B7BF@seranoa.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Andrew Dixon wrote:


> Any insight that people could give would be greatly appreciated.
It's either the FCC or the server.  Since you have the FCC working in PPCBoot
and I've used FCC2 on other boards, I may assume the driver is working.

Since you have DHCP/BOOTP configured in the kernel, do you have a dhcp server
and can you simply try 'root=/dev/nfs rw ip=any' and see if you can talk to
dhcp?  You could also use your favorite network sniffer to see what traffic,
if any, went along the network.

Thanks.

	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
