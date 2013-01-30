Return-Path: <vneethv@gmail.com>
Received: from mail-wi0-f181.google.com (mail-wi0-f181.google.com
 [209.85.212.181])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 50EB52C0087
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2013 13:20:09 +1100 (EST)
Received: by mail-wi0-f181.google.com with SMTP id c10so1082862wiw.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2013 18:20:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFbQSaBm-0ROHX80JQN6ef4Hgy1PgH8PmYRSRpyJ1+mNo+HnbQ@mail.gmail.com>
References: <CAFbQSaBm-0ROHX80JQN6ef4Hgy1PgH8PmYRSRpyJ1+mNo+HnbQ@mail.gmail.com>
From: Vineeth <vneethv@gmail.com>
Date: Wed, 30 Jan 2013 07:49:45 +0530
Message-ID: <CAFbQSaCxSVDRW=kcjkrbrm=8Sy4N0q29ALfqb4o3UdB3crY64g@mail.gmail.com>
Subject: PREMPT_RT
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=f46d043c7b98063bf004d478266c
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--f46d043c7b98063bf004d478266c
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I've added a VDSO patch on my 2.6.32 kernel. When i enabled PREMPT_RT i am
getting the below oops messages.
What is the reason for this ? When googled, it was mentioned in many places
that it is caused by the get_cpu()/put_cpu() preempt disabled region.
Can someone help me to understand this ?

Thanks

--f46d043c7b98063bf004d478266c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><div class=3D"gmail_quote"><span style=3D"font-family:trebuchet ms,sans=
-serif">Hi,<br><br>I&#39;ve added a VDSO patch on my 2.6.32 kernel. When i =
enabled PREMPT_RT i am getting the below oops messages.<br>What is the reas=
on for this ? When googled, it was mentioned in many places that it is caus=
ed by the get_cpu()/put_cpu() preempt disabled region.<br>


Can someone help me to understand this ?<br><br>Thanks<div class=3D"yj6qo a=
jU"><div id=3D":12k" class=3D"ajR" tabindex=3D"0"></div></div></span></div>=
<br>

--f46d043c7b98063bf004d478266c--
