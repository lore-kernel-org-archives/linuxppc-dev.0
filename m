Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 404F71A000C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 21:39:11 +1100 (AEDT)
Date: Tue, 16 Feb 2016 11:39:07 +0100
From: Torsten Duwe <duwe@lst.de>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: Petr Mladek <pmladek@suse.com>, Balbir Singh <bsingharora@gmail.com>,
 Jessica Yu <jeyu@redhat.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Jiri Kosina <jkosina@suse.cz>,
 live-patching@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v8 8/8] livepatch: Detect offset for the ftrace
 location during build
Message-ID: <20160216103907.GB25103@lst.de>
References: <20160210174221.EBBEC692C8@newverein.lst.de>
 <20160210174517.8347D692C8@newverein.lst.de>
 <1455293609.16012.9.camel@gmail.com> <20160212164517.GO12548@pathway.suse.cz>
 <20160216054701.GA20570@linux.vnet.ibm.com> <20160216082302.GA20522@lst.de>
 <20160216103028.GA10730@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160216103028.GA10730@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 16, 2016 at 04:00:30PM +0530, Kamalesh Babulal wrote:
> * Torsten Duwe <duwe@lst.de> [2016-02-16 09:23:02]:
> > 
> > N.b.: if you try to livepatch/trace such a leaf function without
> > global dependencies, it will crash if that function got called with
> > a different TOC value. Hence this whole testing.
> > 
> 
> I am running out of ideas on how to generate this crash, any pointers
> will be helpful.

Petr discovered some modular SCSI helper function does it.

HTH,
	Torsten
