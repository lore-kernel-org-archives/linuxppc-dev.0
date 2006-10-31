Return-Path: <kallepokki@gmail.com>
Received: from nz-out-0102.google.com (nz-out-0102.google.com [64.233.162.204])
	by ozlabs.org (Postfix) with ESMTP id BA97767BD4
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 31 Oct 2006 23:24:46 +1100 (EST)
Received: by nz-out-0102.google.com with SMTP id z31so1359105nzd
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 31 Oct 2006 04:24:45 -0800 (PST)
Message-ID: <a425f86c0610310424l694bdafcsaa0ae110ac056404@mail.gmail.com>
Date: Tue, 31 Oct 2006 14:24:45 +0200
From: "Kalle Pokki" <kalle.pokki@iki.fi>
Sender: kallepokki@gmail.com
To: linuxppc-embedded@ozlabs.org, marcelo.tosatti@cyclades.com
Subject: 8 MB D-TLB's break 8xx without CONFIG_8xx_CPU6
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

Hi,

Can you please review the 8 MB D-TLB change introduced by
8f069b1a90bd97bf6d59a02ecabf0173d9175609 again? Even though I also
have the two patches that fix this commit, I always get an oops when
the init process is supposed to start. The only way to run the board
is to have CONFIG_8xx_CPU6 enabled, and I'd rather avoid that since I
only have 860's with the D.4 mask that are not supposed to be affected
by CPU6.
