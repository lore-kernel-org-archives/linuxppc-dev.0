To: "ppc linux embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Getting rid of static IO mapping
References: <40EB28C7.5020105@246tNt.com>
From: "Linh Dang" <linhd@nortelnetworks.com>
Date: Tue, 06 Jul 2004 23:58:56 -0400
In-Reply-To: <40EB28C7.5020105@246tNt.com> (Sylvain Munaut's message of
 "Tue, 6 Jul 2004 18:33:43 -0400")
Message-ID: <wn5isd0jwn3.fsf@linhd-2.ca.nortel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On 6 Jul 2004, tnt@246tnt.com wrote:
[...]
> I wonder how it works. At the mapin_ram(), my BAT are overwritten,

No they're not. the BAT configurations (which will be used later by
load_up_mmu) are written, NOT the BATs themselves.

> then the "MMU:setio" progress is called, but at this point, my BAT
> is no longer active and my setup_io_mappings is not yet
> called. Shouldn't that crash ? During these two calls, the uart zone
> shouldn't be mapped.

setup_io_mappings is similar to mapin_ram. the configurations are
changed but not the BATs.

--
Linh Dang

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
