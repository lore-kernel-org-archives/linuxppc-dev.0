Return-Path: <Glenn.G.Hart@us.westinghouse.com>
Received: from swec9607.wecnq.com (swec9607.wecnq.com [147.72.234.65])
	by ozlabs.org (Postfix) with ESMTP id D8F46DDF76
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Jun 2007 00:39:41 +1000 (EST)
Subject: Re: base system for avnet virtex 4 fx mini module
To: linuxppc-embedded@ozlabs.org
Message-ID: <OF6973B393.362F7F10-ON852572FF.004ECB8A-852572FF.004F36FD@ct.wec.com>
From: Glenn.G.Hart@us.westinghouse.com
Date: Tue, 19 Jun 2007 10:25:14 -0400
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



I am also using the Avenet MM.  The best luck I have had was using EDK8.2
and the updated board support from Avent.  Once I has these I was able to
add the TEMAC and PLB memory controller.  These seemed to be the key.  I
have not tried the flash device.  I am also having trouble with the
network.

Glenn


>Dear all,
>
>After brining up linux on ML403 I'm now going toward using AVNET mini
module as the next step
>
>I studied available examples from AVNET and I can not find any suitable
base system with both of TEMAC and Flash memory interfaces available in it.
>
>Does any body here can share his EDK project on AVNET mini module with me?
Mainly I need a base system with both of Hard TEMAC, PLB TEMAC and EMC
flash interface >available in it.
>
>thanks for kindness and help,
>mohammad sadegh sadri
>
>_________________________________________________________________
>Explore the seven wonders of the world
>http://search.msn.com/results.aspx?q=7+wonders+world&mkt=en-US&form=QBRE
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
