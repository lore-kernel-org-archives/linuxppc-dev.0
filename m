In-Reply-To: <20040402045027.GG21226@plato.local.lan>
References: <20BB0EB5-841D-11D8-9FF0-000A95A07384@sands-edge.com> <20040402045027.GG21226@plato.local.lan>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <BDE6B8B0-8525-11D8-9FF0-000A95A07384@sands-edge.com>
Cc: linuxppc-dev@lists.linuxppc.org
From: John Whitney <johnw@sands-edge.com>
Subject: Re: arch/ppc/Makefile wiping out /dev/null
Date: Fri, 2 Apr 2004 23:16:55 -0500
To: Ethan Benson <erbenson@alaska.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ethan,

Can you explain the insecurity a bit more?  Any ideas on a better
construct that won't cause /dev/null to be erased in some cases?  I
just want a solution, it doesn't have to be the one I put in there. :-)

Would it be possible just to do something like "$(AS) --version"
instead, as this code is theoretically just checking for an old version
of as?

John

On Apr 1, 2004, at 11:50 PM, Ethan Benson wrote:
>
> On Thu, Apr 01, 2004 at 03:42:44PM -0500, John Whitney wrote:
>>
>> NEW_AS := $(shell echo dssall | $(AS) -o /tmp/.as.$$$$ >/dev/null 2>&1
>> ; echo $$?)
>
> depending on the behavior of $(AS) this is not secure.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
