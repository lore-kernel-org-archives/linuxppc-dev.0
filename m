In-Reply-To: <1080961463.1426.82.camel@gaston>
References: <49B568CB-832A-11D8-9FF0-000A95A07384@sands-edge.com> <1080787943.1434.47.camel@gaston> <209F76E4-838B-11D8-9FF0-000A95A07384@sands-edge.com> <1080790433.1433.59.camel@gaston> <43B0E668-84BC-11D8-9FF0-000A95A07384@sands-edge.com> <1080961463.1426.82.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <9A36C53E-8520-11D8-9FF0-000A95A07384@sands-edge.com>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
From: John Whitney <johnw@sands-edge.com>
Subject: Re: Proposed changes to io.h
Date: Fri, 2 Apr 2004 22:40:08 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> We could add a runtime check to pci_map_single() to verify it gets
> passed an address within the linear mapping though. That would catch
> the bugs you are afraid of.

Might not be bad to add this as a conditional under one of the SANITY
type kernel hacking config options.

> (Oh, and let's keep those discussions on-list).
>

Sorry, Ben.  I'll shut up about it now, I promise. :-)

John


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
