Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.177])
	by ozlabs.org (Postfix) with ESMTP id AC2DEDDFFB
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 00:29:12 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so671448wag
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 07:29:11 -0700 (PDT)
Message-ID: <fa686aa40710110729o1a7f27dfn2791fae8cc7f4bff@mail.gmail.com>
Date: Thu, 11 Oct 2007 08:29:10 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Paul Mackerras" <paulus@samba.org>
Subject: Re: powerpc commits for 2.6.24
In-Reply-To: <18190.5965.836544.396721@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <18190.5965.836544.396721@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/11/07, Paul Mackerras <paulus@samba.org> wrote:
> Below is the list of commits that I plan to ask Linus to pull
> tomorrow.  This is the last call for anything else or for objections
> to any of these commits going in.  These commits are in powerpc.git on
> the master and for-2.6.24 branches.
>

How about these 4?  Do you want to pull them directly, or would you
rather me repost them to the list?

are available in the git repository at:

 git://git.secretlab.ca/git/linux-2.6-mpc52xx.git for-2.6.24

Grant Likely (4):
     [POWERPC] MPC52xx: Drop show_cpuinfo platform hooks from Lite5200
     [POWERPC] MPC52xx: Trim includes on mpc5200 platform support code
     [POWERPC] MPC5200: Don't make firmware fixups into common code
     [POWERPC] Add co-maintainer for PowerPC MPC52xx platform

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
