Return-Path: <galak@kernel.crashing.org>
Message-Id: <DF68B2B7-AFFF-4C86-AC27-55FFE5025C43@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Josh Boyer <jwboyer@linux.vnet.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: patchwork states and workflow
Date: Fri, 19 Sep 2008 16:51:13 -0500
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Jeremy Kerr <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Guys,

I've always been a bit confused about some of the states we can put a  
patch in.  For example, what does 'archiving' a patch mean?

What's the difference between 'deferred' and 'rejected'?  Is 'Under  
Review' useful?

My biggest question is how to manage the transition of 'Accepted' and  
'Awaiting Upstream' and having clear definitions of what we think  
these mean.

My preference is 'Accepted' means its been applied to someone's tree  
(mine, josh's, paul's, etc.) and 'Awaiting Upstream' is the state it  
goes into if we are waiting for a pull by Paul or Linus.  This does  
raise the issue of what state things should be in after the pull.

Comments?

- k
