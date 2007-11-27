Return-Path: <dell.query@yahoo.com>
Received: from n8b.bullet.mail.tp2.yahoo.com (n8b.bullet.mail.tp2.yahoo.com
	[203.188.202.120]) by ozlabs.org (Postfix) with SMTP id 20A1ADDDF2
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Nov 2007 21:02:29 +1100 (EST)
Date: Tue, 27 Nov 2007 01:57:05 -0800 (PST)
From: Dell Query <dell.query@yahoo.com>
Subject: Re: How to map addresses beyond 4GB
To: Dan Malek <dan@embeddedalley.com>
In-Reply-To: <A54CDFF0-EF7A-445B-8A1E-E211E5D267D9@embeddedalley.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1276259793-1196157425=:79614"
Message-ID: <371506.79614.qm@web45606.mail.sp1.yahoo.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1276259793-1196157425=:79614
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Thanks

Dan Malek <dan@embeddedalley.com> wrote: 
On Nov 22, 2007, at 2:42 AM, Dell Query wrote:

> May I know how to map this one?

Just call ioremap() as usual.  It will understand the > 4G
physical address and return a useful virtual address
to you.

 -- Dan



       
---------------------------------
Never miss a thing.   Make Yahoo your homepage.
--0-1276259793-1196157425=:79614
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Thanks<br><br><b><i>Dan Malek &lt;dan@embeddedalley.com&gt;</i></b> wrote:<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> <br>On Nov 22, 2007, at 2:42 AM, Dell Query wrote:<br><br>&gt; May I know how to map this one?<br><br>Just call ioremap() as usual.  It will understand the &gt; 4G<br>physical address and return a useful virtual address<br>to you.<br><br> -- Dan<br><br></blockquote><br><p>&#32;



      <hr size=1>Never miss a thing.  <a href="http://us.rd.yahoo.com/evt=51438/*http://www.yahoo.com/r/hs"> Make Yahoo your homepage.</a>


--0-1276259793-1196157425=:79614--
