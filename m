In-Reply-To: <s0f7edc2.025@EMAIL>
References: <s0f7edc2.025@EMAIL>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <BE104C18-D71D-11D8-B668-003065F9B7DC@embeddededge.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
From: Dan Malek <dan@embeddededge.com>
Subject: Re: Why not kmalloc() ??
Date: Fri, 16 Jul 2004 07:46:15 -0400
To: "Rupesh S" <rupeshs@myw.ltindia.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Jul 16, 2004, at 5:25 AM, Rupesh S wrote:

> 1) Can somebody throw some light on what exactly is the difference
> between m8xx_cpm_hostalloc() and kmalloc().

1) Cache coherency, and 2) need to allocate memory to CPM before the
kernel memory allocator has been initialized.

> 2) Why is the difference important in ppc linux ?

It's unique to the 8xx/82xx/85xx CPM peripherals that are used early
in the kernel start up process, not to the PowerPC Linux in general.

	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
