Date: Tue, 22 Jul 2003 10:12:29 +1200
From: Robin Gilks <robin.gilks@tait.co.nz>
Subject: Re: Problem with starting up 2.4.21 kernel
In-reply-to: <3F1C6210.1080800@tait.co.nz>
To: linuxppc mail list <linuxppc-embedded@lists.linuxppc.org>
Message-id: <3F1C654D.7070907@tait.co.nz>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
References: <3F0B9F69.1030801@tait.co.nz>
 <1058776120.17484.24.camel@localhost.localdomain> <3F1C6210.1080800@tait.co.nz>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>> After "Transferring control to Linux (at address 00000000)" nothing
>> seems happen (see below).
>>

A further problem is that we had the IMMR mapped below the Linux virtual
address of 0xc0000000 which caused it to hang in CPM_reset. Changing
from 0x21000000 to 0xff000000 fixed that problem.

--
Robin Gilks
Senior Design Engineer              Phone: (+64)(3) 357 1569
Tait Electronics                          Fax  :  (+64)(3) 359 4632
PO Box 1645 Christchurch        Email : robin.gilks@tait.co.nz
New Zealand


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
