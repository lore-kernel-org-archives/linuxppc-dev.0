Return-Path: <linuxppc.embedded@gmail.com>
Received: from nz-out-0102.google.com (nz-out-0102.google.com [64.233.162.196])
	by ozlabs.org (Postfix) with ESMTP id 6AEE767C37
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Aug 2006 17:14:31 +1000 (EST)
Received: by nz-out-0102.google.com with SMTP id i1so450135nzh
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Aug 2006 00:14:30 -0700 (PDT)
Message-ID: <9b6b8b5a0608250014q4344bdf4vadcf30cf47b83c6d@mail.gmail.com>
Date: Fri, 25 Aug 2006 15:14:30 +0800
From: "Yong Wang" <linuxppc.embedded@gmail.com>
To: lk99336@pobox.sk
Subject: Re: communication with i2c client
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_128096_965510.1156490070068"
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_128096_965510.1156490070068
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I think you should check the i2c drivers first.
Only the i2c drivers support the slave mode, the user space application can
access the i2c device.
The i2c drivers should modify the mode register of i2c controller to switch
the mode.

------=_Part_128096_965510.1156490070068
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>I think you should check the i2c drivers first. </div>
<div>Only the i2c drivers support the slave mode, the user space application can access the i2c device.</div>
<div>The i2c drivers should modify the mode register of i2c controller to switch the mode.</div>

------=_Part_128096_965510.1156490070068--
