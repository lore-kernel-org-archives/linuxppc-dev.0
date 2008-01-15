Return-Path: <subbu.linux@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.232])
	by ozlabs.org (Postfix) with ESMTP id 1F48CDDEB7
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Jan 2008 07:17:02 +1100 (EST)
Received: by wx-out-0506.google.com with SMTP id h27so1635347wxd.15
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Jan 2008 12:17:00 -0800 (PST)
Message-ID: <f807f08a0801151216l59400ca0i746424a84befc7a8@mail.gmail.com>
Date: Tue, 15 Jan 2008 15:16:59 -0500
From: "Subbu Linux" <subbu.linux@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Linux with e500 v2 core,
	can we support Ram base address starting at 0x1_0000_0000
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_18862_5879758.1200428219681"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_18862_5879758.1200428219681
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi
I am currently working on MPC8548 core, would like to know wheather current
Linux with e500v2 core supporting Physical Address of RAM at 0x1_0000_0000,
I know in current linux with large Page table support we can access devices
at 0x1_0000_0000 for e500v2, but I wanted to move RAM base address to
0x1_0000_0000, so that I can support larger RAM. Can any body suggest me if
their is any patch available for this or is it possible to implement from
scratch.

Thanks
Subbu

------=_Part_18862_5879758.1200428219681
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi</div>
<div>I am currently working on MPC8548 core, would like to know wheather current Linux with e500v2 core supporting Physical Address of RAM at 0x1_0000_0000, I know in current linux with large Page table support we can access devices at 0x1_0000_0000 for e500v2, but I wanted to move RAM base address to 0x1_0000_0000, so that I can support larger RAM.&nbsp;Can any body suggest&nbsp;me if their is any patch available for this or&nbsp;is it possible to implement from scratch.
</div>
<div>&nbsp;</div>
<div>Thanks</div>
<div>Subbu</div>

------=_Part_18862_5879758.1200428219681--
