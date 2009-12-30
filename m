Return-Path: <Gavin.Shan@alcatel-lucent.com>
Received: from cnshjsmin03.cn.alcatel-lucent.com
	(cnmailgate04.alcatel-sbell.com.cn [211.144.215.47])
	by ozlabs.org (Postfix) with ESMTP id D710DB6EF0
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 30 Dec 2009 08:53:09 +1100 (EST)
Message-ID: <4B3B30BF.3080504@alcatel-lucent.com>
Date: Wed, 30 Dec 2009 05:51:43 -0500
From: gshan <gshan@alcatel-lucent.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: xmon & SCSI ATA devices
References: <4B33197D.9000506@alcatel-lucent.com>	
	<1262079428.2173.218.camel@pasglop>
	<4B3AD271.1050105@alcatel-lucent.com>
	<1262121685.2173.220.camel@pasglop>
In-Reply-To: <1262121685.2173.220.camel@pasglop>
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
<blockquote cite="mid1262121685.2173.220.camel@pasglop" type="cite">
  <pre wrap="">On Tue, 2009-12-29 at 23:09 -0500, gshan wrote:

  </pre>
  <blockquote type="cite">
    <pre wrap="">Actually, the situation I described above has caused lots of disk issue.
The DPT (disk partition table) might be lost because of this. I think it's
broken the rule: xmon is assisting to resolve kernel issue, not cause
more.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Well, mostly xmon kicks in when you already oopsed or crashed so .. :-)

As I said, getting into the SCSI stack or similar would make the whole
thing extremely fragile. But you may want to hack something for
yourself, feel free to do so.
  </pre>
</blockquote>
ok. Thank you very much for you suggestions, Ben ;-)<br>
<blockquote cite="mid1262121685.2173.220.camel@pasglop" type="cite">
  <pre wrap="">
Cheers,
Ben.


  </pre>
</blockquote>
<br>
</body>
</html>
