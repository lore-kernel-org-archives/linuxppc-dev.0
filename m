Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 11B3ADDEB6
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 01:00:46 +1000 (EST)
Message-ID: <4714D20A.3080607@garzik.org>
Date: Tue, 16 Oct 2007 11:00:26 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Joachim Fenkes <fenkes@de.ibm.com>
Subject: Re: [PATCH 4/5] ibmebus: Move to of_device and of_platform_driver,
	match eHCA and eHEA drivers
References: <OF48E0997F.B61F7220-ONC125736F.002D7F06-C125736F.002DD39C@de.ibm.com>
	<200710162320.00630.fenkes@de.ibm.com>
In-Reply-To: <200710162320.00630.fenkes@de.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Thomas Q Klein <tklein@de.ibm.com>, Jan-Bernd Themann <THEMANN@de.ibm.com>,
	netdev@vger.kernel.org, Paul Mackerras <pmac@au1.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <raisch@de.ibm.com>, Marcus Eder <meder@de.ibm.com>,
	Paul Mackerras <paulus@samba.org>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Joachim Fenkes wrote:
> On Tuesday 09 October 2007 10:21, Jan-Bernd Themann wrote:
>> Roland Dreier <rdreier@cisco.com> wrote on 03.10.2007 20:05:44:
>>>  > > Replace struct ibmebus_dev and struct ibmebus_driver with struct 
> of_device
>>>  > > and struct of_platform_driver, respectively. Match the external 
> ibmebus
>>>  > > interface and drivers using it.
>>>  > >
>>>  > > Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
>>>  >
>>>  > This is somewhat difficult as this patch touches files that are the
>>>  > responsibility of three different maintainers. �Is it possible to
>>>  > split the patch into three, one for each maintainer (possibly by
>>>  > keeping both old and new interfaces around for a little while)?
>>>  > 
>>>  > If not, then you need to get an Acked-by and an agreement that this
>>>  > change can go via the powerpc.git tree from Roland Dreier and Jeff
>>>  > Garzik.
>>>
>>> I don't see anything objectionable in the infiniband parts of the
>>> patch -- I don't have any way to test the changes but it all looks
>>> like a straightforward conversion to a new platform API.  So:
>>>
>>> Acked-by: Roland Dreier <rolandd@cisco.com>
>>>
>>>  - R.
>> Looks good from eHEA driver perspective.
>>
>> Acked-by: Jan-Bernd Themann <themann@de.ibm.com>
> 
> Jeff, do you have any objections against this patch going into the kernel
> via Paul's powerpc.git tree? It touches only a few lines of ehea which are
> specific to the bus interface changes.
> 
> You can see the full patch here:
>   http://patchwork.ozlabs.org/linuxppc/patch?id=13750
> 
> If you have no objections, please ack the patch so Paul can include it.

Fine with me...

	Jeff
