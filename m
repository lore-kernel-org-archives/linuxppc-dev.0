Message-ID: <3FCF3EB7.5080404@embeddededge.com>
Date: Thu, 04 Dec 2003 09:03:35 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Wojciech Kromer <krom@dgt-lab.com.pl>
Cc: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: memory problem with fec on 8250
References: <3FCD956B.8030604@gazeta.pl> <3FCEF441.2030808@dgt-lab.com.pl> <20031204091536.GA1050@gate.ebshome.net> <3FCF0252.7070202@dgt-lab.com.pl> <20031204101901.GB1050@gate.ebshome.net> <3FCF0E68.4010303@dgt-lab.com.pl> <20031204105532.GA2065@gate.ebshome.net> <3FCF19C3.9070205@dgt-lab.com.pl>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wojciech Kromer wrote:

> _anyone_ knows why there is such difference between allocs and frees in
> fcc_enet.c

What kernel and driver is this?

The latest one I checked into linuxppc_2_4_devel a long time ago
had the benefit of being tested at the UNH Interoperability Laboratory.
This included performance testing and error recovery.  For this driver
to be failing, it must have been modified from that version and we
need to determine what was done to get it corrected.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
