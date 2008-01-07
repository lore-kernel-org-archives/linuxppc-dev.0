Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.241])
	by ozlabs.org (Postfix) with ESMTP id 5BCC9DDEF3
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 06:34:03 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so1532589anc.78
	for <linuxppc-dev@ozlabs.org>; Mon, 07 Jan 2008 11:34:03 -0800 (PST)
Message-ID: <fa686aa40801071134t7963a233yb40984e84170d0b7@mail.gmail.com>
Date: Mon, 7 Jan 2008 12:34:02 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Jon Loeliger" <jdl@jdl.com>
Subject: Re: [RFC PATCH 0/3]: Add StorCenter port to arch/powerpc
In-Reply-To: <E1JBwAx-0006Il-CE@jdl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <E1JBwAx-0006Il-CE@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/7/08, Jon Loeliger <jdl@jdl.com> wrote:
> Specifically, it's not quite working yet, and for lack of
> actually getting serial output, we're having some difficulty
> still.  I post it here in a desperate attempt to let some
> eagle-eyed person point out my obvious "D'oh" problem.

Can you access __log_buf in any way at all?

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
