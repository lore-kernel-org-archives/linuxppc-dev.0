In-Reply-To: <718FB936-4514-11D8-8C1D-000A95A0560C@us.ibm.com>
References: <8529B5552D4EAA4DAEDF49650C64B2B437137E@tarpon.mangrovesystems.com> <718FB936-4514-11D8-8C1D-000A95A0560C@us.ibm.com>
Mime-Version: 1.0 (Apple Message framework v609)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <F5959163-453B-11D8-8C1D-000A95A0560C@us.ibm.com>
Cc: "<linuxppc-dev@lists.linuxppc.org> <linuxppc-dev@lists.linuxppc.org>" <linuxppc-dev@lists.linuxppc.org>
From: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: how to read/write registers of CPU or Device from user space
Date: Mon, 12 Jan 2004 14:14:43 -0600
To: "<zjzhou@newrocktech.com> <zjzhou@newrocktech.com>" <zjzhou@newrocktech.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Jan 12, 2004, at 9:31 AM, Hollis Blanchard wrote:

> On Jan 12, 2004, at 7:48 AM, Muhammad Sarwar wrote:
>>
>> From user space access, use mmap.
>
> (Note that it won't work for RAM, but that's not what you're trying to
> do anyways.)

I misunderstood something here; you can in fact remap RAM via /dev/mem.
This mapping will be done with the VM_RESERVED flag set, which was not
acceptable in the context I heard it discussed, but I guess is ok
generally speaking.

--
Hollis Blanchard
IBM Linux Technology Center


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
