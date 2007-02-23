Return-Path: <sipcop009@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.227])
	by ozlabs.org (Postfix) with ESMTP id 7E0E2DDD07
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Feb 2007 16:14:18 +1100 (EST)
Received: by wr-out-0506.google.com with SMTP id 37so464984wra
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Feb 2007 21:14:17 -0800 (PST)
Message-ID: <5a4792c00702222114ycd2b6a5xbec6bc996d99c9ce@mail.gmail.com>
Date: Thu, 22 Feb 2007 21:14:16 -0800
From: "SIP COP 009" <sipcop009@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Gianfar on 8347 sometimes get stuck at startup
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_39616_29414280.1172207656519"
Cc: sipcop009@gmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_39616_29414280.1172207656519
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

We have the our own MPC8349 based board which has 2 GigEs. It is pretty much
modelled similar to the 8349ADS EVAL boards, infact we have zero changes.

The issue that we are seeing -

Sometimes at startup, we have send 2 TX packets to kind-of-kickstart the
TSEC Tranmission. If we send only packet it does not get to the other side.
This does not happen always.

The TSEC Registers dont really show any errors nor does the Marvell PHY show
any errors.

The kernel that we are using is 2.6.11.

Anybody  seen this before or something similar ?

Any pointers will be appreciated. We cannot move to any other kernel
verision right now.

Thanks!
ashutosh

------=_Part_39616_29414280.1172207656519
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>&nbsp;</div>
<div>We have the our own MPC8349 based&nbsp;board which has 2 GigEs. It is pretty much modelled similar to the 8349ADS EVAL boards, infact we have zero changes.</div>
<div>&nbsp;</div>
<div>The issue that we are seeing - </div>
<div>&nbsp;</div>
<div>Sometimes at startup, we have send 2 TX packets to kind-of-kickstart the TSEC Tranmission. If we send only packet it does not get to the other side. This does not happen always.</div>
<div>&nbsp;</div>
<div>The TSEC Registers dont really show any errors nor does the Marvell PHY show any errors.</div>
<div>&nbsp;</div>
<div>The kernel that we are using is 2.6.11.</div>
<div>&nbsp;</div>
<div>Anybody &nbsp;seen this before or something similar ? </div>
<div>&nbsp;</div>
<div>Any pointers will be appreciated. We cannot move to any other kernel verision right now.</div>
<div>&nbsp;</div>
<div>Thanks!</div>
<div>ashutosh</div>
<div>&nbsp;</div>

------=_Part_39616_29414280.1172207656519--
