Return-Path: <adams.ppc@gmail.com>
Received: from hu-out-0506.google.com (hu-out-0506.google.com [72.14.214.238])
	by ozlabs.org (Postfix) with ESMTP id 71529DDF45
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 May 2008 07:24:03 +1000 (EST)
Received: by hu-out-0506.google.com with SMTP id 34so1248726hue.9
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 May 2008 14:24:01 -0700 (PDT)
Message-ID: <4a21eaea0805291423t7e44eae9xbf4c78818d794742@mail.gmail.com>
Date: Thu, 29 May 2008 15:23:59 -0600
From: "bhanu jampala" <adams.ppc@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: platform drivers
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_3275_17986220.1212096239324"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_3275_17986220.1212096239324
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Guys,

I am running the basic PPC Linux on my PPC8270 BRD.
I have to write couple of driver on top of it finish the complete Linux
port.

I have a external chips which controls simple switching, LCD control and
watch dog setup.
I need to write drivers for all of these devices.

I have written couple of driver before this, But, this is my first time to
port a BSP to Linux.
What is driver model that I can use to write on a platform like these.
Will the platform drivers make some sense?

I have read though some of the docs in 'driver-models' folder. I have a fiar
understanding about the Platform drivers.
I wrote one just to see how it works. But, I am not much clean on the
application of these driver models.

I have plans to submit my code to PPC kernel tree so please let me know what
is more appropriate.

-Adams

------=_Part_3275_17986220.1212096239324
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br>Hi Guys,<br>
<br>I am running the basic PPC Linux on my PPC8270 BRD.<br>I have to write couple of driver on top of it finish the complete Linux port.<br><br>I have a external chips which controls simple switching, LCD control and watch dog setup.<br>
I need to write drivers for all of these devices.<br><br>I have written couple of driver before this, But, this is my first time to port a BSP to Linux.<br>What is driver model that I can use to write on a platform like these.<br>
Will the platform drivers make some sense?<br><br>
I have read though some of the docs in &#39;driver-models&#39; folder. I have a fiar understanding about the Platform drivers.<br>I wrote one just to see how it works. But, I am not much clean on the application of these driver models.<br>
<br>I have plans to submit my code to PPC kernel tree so please let me know what is more appropriate.<br><br>-Adams<br>

------=_Part_3275_17986220.1212096239324--
