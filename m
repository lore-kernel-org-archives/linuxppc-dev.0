Return-Path: <norsk5@yahoo.com>
Received: from web50104.mail.re2.yahoo.com (web50104.mail.re2.yahoo.com
	[206.190.38.32]) by ozlabs.org (Postfix) with SMTP id C085BDDEF0
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Oct 2008 10:21:50 +1100 (EST)
Date: Tue, 7 Oct 2008 16:10:09 -0700 (PDT)
From: Doug Thompson <norsk5@yahoo.com>
Subject: Re: [PATCH v2] edac: mpc85xx: Add support for MPC8572
To: Dave Jiang <djiang@mvista.com>, Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <48EB8AF1.6020600@mvista.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-349120485-1223421009=:14504"
Message-ID: <5262.14504.qm@web50104.mail.re2.yahoo.com>
Cc: linuxppc-dev@ozlabs.org, Andrew Kilkenny <akilkenny@xes-inc.com>,
	Nate Case <ncase@xes-inc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0-349120485-1223421009=:14504
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit



Dave Jiang <djiang@mvista.com> wrote: There's an SVN+quilt tree via sourceforge for EDAC. I have asked Doug to push 
this patch upstream to the mm tree.

Kumar Gala wrote:
> 
> On Sep 19, 2008, at 6:20 PM, Nate Case wrote:
> 
>> From: Andrew Kilkenny 
>>
>> This adds support for the dual-core MPC8572 processor.  We have
>> to support making SPR changes on each core.  Also, since we can
>> have multiple memory controllers sharing an interrupt, flag the
>> interrupts with IRQF_SHARED.
>>
>> Signed-off-by: Andrew Kilkenny 
>> Signed-off-by: Nate Case 
>> ---
>> drivers/edac/mpc85xx_edac.c |   28 +++++++++++++++++++++++-----
>> 1 files changed, 23 insertions(+), 5 deletions(-)
> 
> Acked-by: Kumar Gala 
> 
> Guys, is there an edac git tree or something to create patches against?  
> I've got one I've been sitting on but it should be updated based on 
> Nate's patch.
> 
> - k

the SVN repos is 

svn checkout https://bluesmoke.svn.sourceforge.net/svnroot/bluesmoke/trunk

the info page is

http://bluesmoke.sourceforge.net/

doug t



W1DUG
--0-349120485-1223421009=:14504
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<br><br><b><i>Dave Jiang &lt;djiang@mvista.com&gt;</i></b> wrote:<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> There's an SVN+quilt tree via sourceforge for EDAC. I have asked Doug to push <br>this patch upstream to the mm tree.<br><br>Kumar Gala wrote:<br>&gt; <br>&gt; On Sep 19, 2008, at 6:20 PM, Nate Case wrote:<br>&gt; <br>&gt;&gt; From: Andrew Kilkenny <akilkenny@xes-inc.com><br>&gt;&gt;<br>&gt;&gt; This adds support for the dual-core MPC8572 processor.  We have<br>&gt;&gt; to support making SPR changes on each core.  Also, since we can<br>&gt;&gt; have multiple memory controllers sharing an interrupt, flag the<br>&gt;&gt; interrupts with IRQF_SHARED.<br>&gt;&gt;<br>&gt;&gt; Signed-off-by: Andrew Kilkenny <akilkenny@xes-inc.com><br>&gt;&gt; Signed-off-by: Nate Case <ncase@xes-inc.com><br>&gt;&gt; ---<br>&gt;&gt; drivers/edac/mpc85xx_edac.c |   28 +++++++++++++++++++++++-----<br>&gt;&gt; 1 files
 changed, 23 insertions(+), 5 deletions(-)<br>&gt; <br>&gt; Acked-by: Kumar Gala <galak@kernel.crashing.org><br>&gt; <br>&gt; Guys, is there an edac git tree or something to create patches against?  <br>&gt; I've got one I've been sitting on but it should be updated based on <br>&gt; Nate's patch.<br>&gt; <br>&gt; - k<br><br></galak@kernel.crashing.org></ncase@xes-inc.com></akilkenny@xes-inc.com></akilkenny@xes-inc.com></blockquote>the SVN repos is <br><br>svn checkout https://bluesmoke.svn.sourceforge.net/svnroot/bluesmoke/trunk<br><pre>the info page is<br><br>http://bluesmoke.sourceforge.net/<br><br>doug t<br></pre><BR><BR><span style="color: rgb(0, 0, 191);">W1DUG</span>
--0-349120485-1223421009=:14504--
