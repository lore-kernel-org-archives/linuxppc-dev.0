Date: Sat, 16 Feb 2002 18:59:53 -0500
Subject: question on best way to install other ide drives?
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v480)
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
To: linuxppc-dev@lists.linuxppc.org,
	yellowdog-devel@lists.yellowdoglinux.com
In-Reply-To: <40041092-2284-11D6-9EE3-0003938E434C@ivey.uwo.ca>
Message-Id: <453D45A8-2339-11D6-B84B-0003938E434C@ivey.uwo.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

My dual 1 Gig machine has room to easily mount a second (slave) ide
drive.  I also have an Sonnet ATA-100 pci card and another IDE drive.

I would like to add both.  The Sonnet card can support up to 4 IDE
drives.

Would it be better (performancewize) to:

A.  Hook both drives up the the ATA-100 pci card using two ribbon cables
with both being masters?

B.  Hook only 1 to the ATA-100 (a master) and use the second as slave
off the the included IDE card?

C. Hook both to one ATA-100 card using one as master and one as slave.

Any guidance here would be greatly appreciated.

Thanks,

Kevin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
