Return-Path: <ktdann@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.192])
	by ozlabs.org (Postfix) with ESMTP id 7CE7867E55
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 Aug 2005 11:27:18 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 68so20288wri
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 02 Aug 2005 18:27:17 -0700 (PDT)
Message-ID: <9b7ca65705080218273146950c@mail.gmail.com>
Date: Wed, 3 Aug 2005 10:27:16 +0900
From: Daniel Ann <ktdann@gmail.com>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: Issue with running depmod after cross compiling
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hey folks,

For certain, I understand why running make module_install fails if I
run it after cross compiling the kernel+module.
What I'm doing now is, I've just commented out the bit in Makefile
(where it exec's depmod), and everythings cool.

BUT, problem with this method is, I get none of the module.dep and
many related files for auto loading of module.

What would be considered reasonable if I was to solve this ?

Thanks for your thought on this in advance.

--=20
Daniel
