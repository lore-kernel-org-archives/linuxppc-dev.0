In-Reply-To: <20040827221204.GB30360@smtp.west.cox.net>
References: <1093602389.1862.54.camel@localhost> <20040827221204.GB30360@smtp.west.cox.net>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <A3F2DB9A-F88A-11D8-8E7D-003065F9B7DC@embeddededge.com>
Cc: paulus@samba.org, Adrian Cox <adrian@humboldt.co.uk>,
	linuxppc-dev@lists.linuxppc.org
From: Dan Malek <dan@embeddededge.com>
Subject: Re: [PATCH,RFC] PPC32 Machine Check Handling
Date: Fri, 27 Aug 2004 20:38:54 -0400
To: Tom Rini <trini@kernel.crashing.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Aug 27, 2004, at 6:12 PM, Tom Rini wrote:

>> The PowerMac and Qspan specific code is moved into platform files.
>> There
>> don't seem to be any boards in the tree that actually use Qspan PCI.

The MBX-860, RPC Classic (with PCI enabled) are two well known
boards that use the Qspan.  I don't know many people that use those
boards, I'm just listing them for documentation purposes :-)  There
are also some custom boards that use it, but I suspect it won't
affect them.

Thanks.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
