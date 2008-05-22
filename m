Return-Path: <bart.vanassche@gmail.com>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.191])
	by ozlabs.org (Postfix) with ESMTP id 8B427DDFFC
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 03:50:12 +1000 (EST)
Received: by fk-out-0910.google.com with SMTP id e30so200123fke.9
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 10:50:08 -0700 (PDT)
Message-ID: <e2e108260805221050s3ee280an8155898c216c334c@mail.gmail.com>
Date: Thu, 22 May 2008 19:50:08 +0200
From: "Bart Van Assche" <bart.vanassche@gmail.com>
To: "Chris Friesen" <cfriesen@nortel.com>
Subject: Re: section mismatch warnings in current git head for powerpc
In-Reply-To: <4835ABDB.8020901@nortel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4835ABDB.8020901@nortel.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 22, 2008 at 7:22 PM, Chris Friesen <cfriesen@nortel.com> wrote:
> I got the following warnings when building current git head for powerpc
> 64bit:

Something that should be fixed, but not something to worry about.
Similar warnings appear when building the kernel for x86_64. See also
http://lkml.org/lkml/2008/4/13/98, http://lkml.org/lkml/2008/4/17/202
and http://bugzilla.kernel.org/show_bug.cgi?id=9974.

Bart.
