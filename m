In-Reply-To: <GEEKLLHMFHLAJOBEEELHGEDNCJAA.tmike@recipes4linux.com>
References: <GEEKLLHMFHLAJOBEEELHGEDNCJAA.tmike@recipes4linux.com>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <FCDC4B3D-959C-11D8-9F76-003065F9B7DC@embeddededge.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
From: Dan Malek <dan@embeddededge.com>
Subject: Re: FEC support for 8260 in kernel 2.4.25
Date: Fri, 23 Apr 2004 23:10:49 -0400
To: "T Michael Turney" <tmike@recipes4linux.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Apr 23, 2004, at 7:23 PM, T Michael Turney wrote:

> Is anybody out there successfully using the 2.4.x
> fcc_enet.c code with all three channels active?

Sure.

There are lots of I/O pins that have to be configured correctly for
clocks and data lines.  It can take a while to get this right, but the
driver has the typical configurations ready to go out of the box.

	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
