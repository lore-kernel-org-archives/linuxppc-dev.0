Mime-Version: 1.0 (Apple Message framework v618)
In-Reply-To: <wn5wu0qsn13.fsf@linhd-2.ca.nortel.com>
References: <wn5wu0qsn13.fsf@linhd-2.ca.nortel.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <EB9CAD60-DF2E-11D8-910D-003065F9B7DC@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Subject: Re: BAT mapping exported to user-space
Date: Mon, 26 Jul 2004 14:09:22 -0400
To: "Embedded Linux PPC list" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Jul 26, 2004, at 1:20 PM, Linh Dang wrote:

> - has it been discussed/comptemplate/done before?

Of course.  Use mmap(), either on /dev/mem directly, or more
preferable through a simple device driver for your ASIC that
could also do simple system protection.

Please don't be making such memory mapping kernel
modifications.  It will only cause future trouble.

	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
