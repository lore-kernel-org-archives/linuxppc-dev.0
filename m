Message-ID: <20030313032122.94630.qmail@web41506.mail.yahoo.com>
Date: Wed, 12 Mar 2003 19:21:22 -0800 (PST)
From: bhupinder sahran <bhup_sah@yahoo.com>
Subject: pci_alloc_consistent size more than 4mb
To: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <00df01c2e90a$85fc3b80$af85efcb@qhavm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi guys

I am using pci_alloc_consistent system call in one of
the driver. I need to get 16 mb of consistent memory.
But i am seeing that i can get maximum 4mb of memory
through pci_alloc_consistent or get_free_pages. Is
there anyway we can get 16mb of consistent memory from
the OS. I am using kernel version 2.4.7.

Can any of u through a pointer here.

Thanx
Bhupi


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
