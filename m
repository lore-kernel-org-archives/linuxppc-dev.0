Date: Wed, 12 Mar 2003 21:09:35 -0700
From: Matt Porter <porter@cox.net>
To: bhupinder sahran <bhup_sah@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: pci_alloc_consistent size more than 4mb
Message-ID: <20030312210935.A30677@home.com>
References: <00df01c2e90a$85fc3b80$af85efcb@qhavm> <20030313032122.94630.qmail@web41506.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030313032122.94630.qmail@web41506.mail.yahoo.com>; from bhup_sah@yahoo.com on Wed, Mar 12, 2003 at 07:21:22PM -0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Mar 12, 2003 at 07:21:22PM -0800, bhupinder sahran wrote:
>
> Hi guys
>
> I am using pci_alloc_consistent system call in one of
> the driver. I need to get 16 mb of consistent memory.
> But i am seeing that i can get maximum 4mb of memory
> through pci_alloc_consistent or get_free_pages. Is
> there anyway we can get 16mb of consistent memory from
> the OS. I am using kernel version 2.4.7.

Um, 2MB on 2.4. MAX_ORDER=10 as far as I recall back on 2.4.
On 2.5 it's 11 and you can get 4MB max.

Please read the mailing list...I answered this question just
a few hours ago.

-Matt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
