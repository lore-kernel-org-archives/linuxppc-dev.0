Return-Path: <lmejjad@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.188])
	by ozlabs.org (Postfix) with ESMTP id 33D68DDEF0
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Apr 2008 00:09:05 +1100 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so1805726rvf.9
	for <linuxppc-dev@ozlabs.org>; Thu, 03 Apr 2008 06:09:04 -0700 (PDT)
Message-ID: <9b4863980804030609s3ff05c33g462ffc1769546010@mail.gmail.com>
Date: Thu, 3 Apr 2008 09:09:04 -0400
From: "mejjad lahcen" <lmejjad@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: interrupt latency spi
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_665_31372743.1207228144622"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_665_31372743.1207228144622
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

 hi all of you ,
I am wndering if someone has already done test for interrupt latency on
linx 2.6.23 mpc5200b.
I am working on writing a driver which is get SPi involved on design, and I
know that the  spi interrupt will occurs at every 2 us ( speed 4 MHz
interupt occurs when It recieves on bytes) so  I am worring about interrupt
latency.
 I dont know if someone has any suggestions or a litle advice.
cheers

------=_Part_665_31372743.1207228144622
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>&nbsp;hi all of you ,</div>
<div>I am wndering if someone has already done test for interrupt latency on&nbsp; linx 2.6.23 mpc5200b.</div>
<div>I am working on writing a driver which is get SPi involved on design, and I know that the&nbsp; spi interrupt will occurs at every 2 us ( speed 4 MHz interupt occurs when It recieves on bytes) so&nbsp; I am worring about interrupt latency.</div>

<div>&nbsp;I dont know if someone has any suggestions&nbsp;or a litle advice.</div>
<div>cheers</div>
<div>&nbsp;</div>
<div>&nbsp;</div>

------=_Part_665_31372743.1207228144622--
