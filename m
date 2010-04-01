Return-Path: <Gavin.Shan@alcatel-lucent.com>
Received: from cnshjsmin03.cn.alcatel-lucent.com (unknown [211.144.215.47])
	by ozlabs.org (Postfix) with ESMTP id 97A1FB7D0A
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  1 Apr 2010 13:42:32 +1100 (EST)
Message-ID: <4BB407F6.3070106@alcatel-lucent.com>
Date: Thu, 01 Apr 2010 10:41:58 +0800
From: gshan <Gavin.Shan@alcatel-lucent.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: spin_lock_irqsave and multi-core
References: <4BB3FE05.6040800@alcatel-lucent.com>
	<1270089545.7101.84.camel@pasglop>
In-Reply-To: <1270089545.7101.84.camel@pasglop>
Content-Type: text/html; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=UTF-8" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Benjamin Herrenschmidt wrote:
<blockquote cite="mid:1270089545.7101.84.camel@pasglop" type="cite">
  <pre wrap="">On Thu, 2010-04-01 at 09:59 +0800, gshan wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">On multi-core system, spin_lock_irqsave() can stop all CPU cores 
receiving interrupts?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
No.
  </pre>
</blockquote>
<small><font face="Arial">Thanks a lot for your answer.</font></small><br>
<blockquote cite="mid:1270089545.7101.84.camel@pasglop" type="cite">
  <pre wrap="">
  </pre>
  <blockquote type="cite">
    <pre wrap="">If the answer is no, what we can do to disable external interrupt for 
all CPU cores?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
You don't :-)

Really, you generally don't. Why would you want to do that ?
  </pre>
</blockquote>
<small><font face="Arial">One of my private driver need it. I don't
know how to do it.</font></small><br>
<blockquote cite="mid:1270089545.7101.84.camel@pasglop" type="cite">
  <pre wrap="">
Cheers,
Ben.


  </pre>
</blockquote>
<br>
</body>
</html>
