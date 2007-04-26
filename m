Return-Path: <patrick.olinet@gmail.com>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.228])
	by ozlabs.org (Postfix) with ESMTP id 234C6DDF56
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Apr 2007 02:10:42 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id l1so960939nzf
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Apr 2007 09:10:41 -0700 (PDT)
Message-ID: <30f6090e0704260910y383ace08g30a7b6899d86ed7e@mail.gmail.com>
Date: Thu, 26 Apr 2007 18:10:41 +0200
From: "Patrick Olinet" <patrick.olinet@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: gcj & PPC405
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello all,

Is there anyone here with experience running gcj (gnu compiler for
java) compiled programs on a PPC405EP CPU ?

The native code produced by gcj runs fine on our embedded target
platform but it crashes when it has to interpret java byte code
("Illegal instruction" error message), although gcj has been compiled
with interpreter enabled.

gcj version is 3.4.3. linux kernel is 2.4.20. Unfortunately, it's hard
for us to upgrade any of them.

Any help would be really appreciated. Thanks in advance.

Regards,
Patrick Olinet
