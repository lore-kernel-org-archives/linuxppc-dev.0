Message-ID: <3D9C7A26.3030602@mvista.com>
Date: Thu, 03 Oct 2002 10:11:02 -0700
From: Todd Poynor <tpoynor@mvista.com>
MIME-Version: 1.0
To: Matt Porter <porter@cox.net>
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Remove ocp-proc.c
References: <20021003062159.GA6160@zax> <20021003075753.B4643@home.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>>This patch completely removes drivers/ocp/ocp-proc.c from 2.5, along
>>with all references to it - it's been terminally broken for some time
>>now.  Shall I commit this to linuxppc-2.5?

Using driverfs instead sounds fine to me.  It's definitely the way to go
if all the other /proc/bus/ denizens are moving to driverfs in the near
future, anyhow.  Even if not, and /proc/bus/ lives on for certain
busses, "ocp" is something of an artificial bus anyhow, and using a
driverfs interface with a structure more closely approximating the real
bus structure of the platform should be a good thing.


--
Todd


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
