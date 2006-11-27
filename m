Return-Path: <jeff@mock.com>
Received: from mail.mock.com (gw.mock.com [209.157.146.194])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.mock.com", Issuer "CAcert Class 3 Root" (not verified))
	by ozlabs.org (Postfix) with ESMTP id AD86867D4D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Nov 2006 09:21:25 +1100 (EST)
Received: from [10.253.169.117] (m810f36d0.tmodns.net [208.54.15.129])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by mail.mock.com (Postfix) with ESMTP id 1D5A772962
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 27 Nov 2006 14:21:14 -0800 (PST)
Message-ID: <456B6475.4010109@mock.com>
Date: Mon, 27 Nov 2006 14:19:33 -0800
From: Jeff Mock <jeff@mock.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: PPC440GX ethernet oddities
References: <456A641D.7070904@mock.com>
	<20061127042554.GB26806@gate.ebshome.net>
	<456B21C3.6040203@mock.com>
	<20061127201859.GA14806@gate.ebshome.net>
In-Reply-To: <20061127201859.GA14806@gate.ebshome.net>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



Eugene Surovegin wrote:
> On Mon, Nov 27, 2006 at 09:34:59AM -0800, Jeff Mock wrote:
>> # ./ethtool -S eth0
>> NIC statistics:
>>      rx_packets: 683430611
>>      rx_bytes: 45405076316
>>      tx_packets: 1331225622
>>      tx_bytes: 2005276384145
>>      rx_packets_csum: 683428670
>>      tx_packets_csum: 1331224150
>>      tx_undo: 0
>>      rx_dropped_stack: 80
>>      rx_dropped_oom: 0
>>      rx_dropped_error: 0
>>      [lots more 0's...]
>>
>> The number of checksum errors seems okay and doesn't really change when
>> I plug in the second network connection, but the ring buffer usage still
>> increases dramatically.
> 
> Stats look OK.  BTW, tx/rx_packets_csum is not a number of checksum 
> errors, that's a number of packets where driver used hw checksum 
> acceleration :).
> 

Ah, silly me.  Can you tell me where I can find the number of received
packets with bad ethernet checksums?  I'm still thinking that I might
have a little hardware problem that is increasing the bit error rate
when I use both ports, ultimately increasing my buffer utilization.

thanks,
jeff
